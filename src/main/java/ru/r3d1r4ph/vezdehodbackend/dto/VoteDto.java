package ru.r3d1r4ph.vezdehodbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Data
@AllArgsConstructor
public class VoteDto {

    @NotBlank(message = "Artist is mandatory")
    private String artist;

    @Pattern(regexp="^9[0-9]{9}",message="Phone length must be 10")
    private String phone;
}
