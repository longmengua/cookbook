package com.example.demo.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Embeddable;

@Embeddable
@NoArgsConstructor
@AllArgsConstructor
public class Name {

    @Getter@Setter
    private String first;

    @Getter@Setter
    private String middle;

    @Getter@Setter
    private String last;

    @Override
    public String toString() {
        return String.format("%s %s %s",first + middle + last);
    }
}