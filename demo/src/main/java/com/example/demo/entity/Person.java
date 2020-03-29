package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.beans.factory.annotation.Required;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
public class Person {

    @Getter@Setter
    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(name = "id", insertable = false, updatable = false, nullable = false)
    private String id;

    @Getter@Setter
    @Embedded
    private Name name;

    @Getter@Setter
    private String age;

    @Getter@Setter
    private String gender;

    @Getter@Setter
    private ZonedDateTime birthday;

    @Getter@Setter
    private ZonedDateTime establishedDay;

    @Getter@Setter
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn()
    private Person supervisor;

    @Getter@Setter
    @OneToMany(mappedBy = "supervisor")
    @JsonIgnore
    private List<Person> subordinate;

    @Getter@Setter
    @ManyToMany(cascade={CascadeType.ALL})
    @JoinTable(name="colleagues_teammates",
            joinColumns={@JoinColumn(name="colleagues_id")},
            inverseJoinColumns={@JoinColumn(name="teammates_id")})
    private Set<Person> colleagues = new HashSet<Person>();

    @ManyToMany(mappedBy="colleagues")
    private Set<Person> teammates = new HashSet<Person>();

    @Getter@Setter
    @NotNull
    private Boolean locked = false;

    @Getter@Setter
    private String notes;

    public Person() {
    }

    public Person(String id, Name name, String age, String gender, ZonedDateTime birthday, ZonedDateTime establishedDay, Person supervisor, List<Person> subordinate, Set<Person> colleagues, Set<Person> teammates, @NotNull Boolean locked, String notes) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.birthday = birthday;
        this.establishedDay = establishedDay;
        this.supervisor = supervisor;
        this.subordinate = subordinate;
        this.colleagues = colleagues;
        this.teammates = teammates;
        this.locked = locked;
        this.notes = notes;
    }
}