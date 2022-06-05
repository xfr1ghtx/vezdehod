package ru.r3d1r4ph.vezdehodbackend.controller;

import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Bucket4j;
import io.github.bucket4j.Refill;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import ru.r3d1r4ph.vezdehodbackend.data.Participants;
import ru.r3d1r4ph.vezdehodbackend.dto.ParticipantDto;
import ru.r3d1r4ph.vezdehodbackend.dto.VoteDto;
import ru.r3d1r4ph.vezdehodbackend.service.VotesService;

import java.time.Duration;
import java.util.List;

@RestController
@RequestMapping("/votes")
@RequiredArgsConstructor
public class VotesController {

    private final VotesService votesService;

    private Bucket bucket;

    @Value("${bucket_limit:100}")
    private Integer BucketLimit;

    @Value("${fill_rate:100}")
    private Integer FillRate;

    public void initBucket() {
        if (this.bucket == null) {
            Bandwidth limit = Bandwidth.classic(BucketLimit, Refill.greedy(FillRate, Duration.ofMinutes(1)));
            this.bucket = Bucket4j.builder()
                    .addLimit(limit)
                    .build();
        }
    }

    @PostMapping
    public ResponseEntity<Void> vote(@Validated @RequestBody VoteDto voteDto) {
        initBucket();
        var consumptionProbe = bucket.tryConsumeAndReturnRemaining(1);
        if (consumptionProbe.isConsumed()) {
            if (Participants.ParticipantsMap.containsKey(voteDto.getArtist())) {
                Participants.ParticipantsMap.put(
                        voteDto.getArtist(),
                        Participants.ParticipantsMap.get(voteDto.getArtist()) + 1
                );
                return ResponseEntity
                        .status(HttpStatus.CREATED)
                        .build();
            } else {
                return ResponseEntity
                        .status(HttpStatus.NOT_FOUND)
                        .build();
            }
        } else {
            return ResponseEntity
                    .status(HttpStatus.TOO_MANY_REQUESTS)
                    .header("x-ratelimit-limit", BucketLimit.toString())
                    .header("x-ratelimit-remaining", String.valueOf(consumptionProbe.getRemainingTokens()))
                    .header("x-ratelimit-reset", String.valueOf(consumptionProbe.getNanosToWaitForRefill()))
                    .build();
        }
    }

    @GetMapping
    public ResponseEntity<List<ParticipantDto>> getVotes() {
        initBucket();
        var consumptionProbe = bucket.tryConsumeAndReturnRemaining(1);
        if (consumptionProbe.isConsumed()) {
            return ResponseEntity
                    .status(HttpStatus.OK)
                    .body(votesService.getParticipantsList());
        } else {
            return ResponseEntity
                    .status(HttpStatus.TOO_MANY_REQUESTS)
                    .header("x-ratelimit-limit", BucketLimit.toString())
                    .header("x-ratelimit-remaining", String.valueOf(consumptionProbe.getRemainingTokens()))
                    .header("x-ratelimit-reset", String.valueOf(consumptionProbe.getNanosToWaitForRefill()))
                    .build();
        }
    }
}
