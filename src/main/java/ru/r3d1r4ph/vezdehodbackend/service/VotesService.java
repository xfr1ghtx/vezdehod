package ru.r3d1r4ph.vezdehodbackend.service;

import ru.r3d1r4ph.vezdehodbackend.dto.ParticipantDto;

import java.util.List;
import java.util.stream.Collectors;

import static ru.r3d1r4ph.vezdehodbackend.data.Participants.ParticipantsMap;

public class VotesService {

    public List<ParticipantDto> getParticipantsList() {
        return ParticipantsMap.entrySet().stream()
                .map(stringIntegerEntry -> new ParticipantDto(stringIntegerEntry.getKey(), stringIntegerEntry.getValue()))
                .collect(Collectors.toList());
    }
}
