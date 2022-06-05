package ru.r3d1r4ph.vezdehodbackend.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import ru.r3d1r4ph.vezdehodbackend.data.Participants;
import ru.r3d1r4ph.vezdehodbackend.dto.MessageDto;
import ru.r3d1r4ph.vezdehodbackend.dto.ParticipantDto;
import ru.r3d1r4ph.vezdehodbackend.dto.VoteDto;
import ru.r3d1r4ph.vezdehodbackend.service.VotesService;

import java.util.List;

@RestController
@RequestMapping("/votes")
@RequiredArgsConstructor
public class VotesController {

    private final VotesService votesService;

    @PostMapping
    public ResponseEntity<MessageDto> vote(@Validated @RequestBody VoteDto voteDto) {
        if (Participants.ParticipantsMap.containsKey(voteDto.getArtist())) {
            Participants.ParticipantsMap.put(
                    voteDto.getArtist(),
                    Participants.ParticipantsMap.get(voteDto.getArtist()) + 1
            );
            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .body(new MessageDto(
                            "Created"
                    ));
        } else {
            return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(new MessageDto(
                            "NotFound"
                    ));
        }
    }

    @GetMapping
    public ResponseEntity<List<ParticipantDto>> getVotes() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(votesService.getParticipantsList());
    }
}
