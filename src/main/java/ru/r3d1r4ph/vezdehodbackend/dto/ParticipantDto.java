package ru.r3d1r4ph.vezdehodbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ParticipantDto {

    private String name;

    private Integer votes;
}
