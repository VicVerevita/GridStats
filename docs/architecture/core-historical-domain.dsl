workspace "SimPaddock - Core Historical Domain" "Conceptual relationship map for source-backed sim motorsport history." {

    model {

        organisation = element "Organisation" {
            description "Canonical organisation responsible for organising one or more competitions."
            tags "Domain Entity"
        }

        competition = element "Competition" {
            description "One concrete occurrence of a source-backed competition, such as VMS 2026."
            tags "Domain Entity,Aggregate Root"
        }

        round = element "Round" {
            description "Optional grouping of races when the trusted source explicitly exposes a round structure."
            tags "Domain Entity,Optional Structure"
        }

        race = element "Race" {
            description "A source-backed race or event within a competition."
            tags "Domain Entity"
        }

        raceResult = element "Race Result" {
            description "Canonical source-backed result for a race."
            tags "Historical Record"
        }

        resultEntry = element "Result Entry" {
            description "Historical result record describing a classified participant or team representation in a specific result."
            tags "Historical Record,Critical Record"
        }

        championshipStanding = element "Championship Standing" {
            description "Source-backed competition-level standing when the trusted source exposes one."
            tags "Historical Record"
        }

        standingEntry = element "Standing Entry" {
            description "One classified driver or team entry within a source-backed championship standing."
            tags "Historical Record"
        }

        driver = element "Driver" {
            description "Canonical sim-racing driver identity."
            tags "Domain Entity,Aggregate Root"
        }

        team = element "Team" {
            description "Canonical sim-racing team identity."
            tags "Domain Entity,Aggregate Root"
        }

        teamMembership = element "Team Membership" {
            description "Explicit historical membership relationship between a Driver and Team. Separate from race representation."
            tags "Historical Relationship"
        }

        car = element "Car" {
            description "Canonical car referenced by a source-backed result when available."
            tags "Catalog Entity"
        }

        carClass = element "Car Class" {
            description "Canonical competition or result car class when established by the source."
            tags "Catalog Entity"
        }

        circuit = element "Circuit" {
            description "Canonical circuit referenced by a race when supplied by the trusted source."
            tags "Catalog Entity"
        }


        organisation -> competition "Organises"

        competition -> round "Contains when the source exposes rounds" {
            tags "Optional Relationship"
        }

        round -> race "Groups" {
            tags "Optional Relationship"
        }

        competition -> race "Contains directly when no round structure is established" {
            tags "Optional Relationship"
        }

        race -> circuit "Takes place at when source-backed" {
            tags "Optional Relationship"
        }


        race -> raceResult "Has source-backed result"

        raceResult -> resultEntry "Contains classified result entries"


        resultEntry -> driver "Records participating driver(s)"

        resultEntry -> team "Records represented team when supplied by the source" {
            tags "Evidence Relationship"
        }

        resultEntry -> car "Records car when supplied by the source" {
            tags "Optional Relationship"
        }

        resultEntry -> carClass "Records class when supplied by the source" {
            tags "Optional Relationship"
        }


        competition -> championshipStanding "Has source-backed championship standing" {
            tags "Optional Relationship"
        }

        championshipStanding -> standingEntry "Contains"

        standingEntry -> driver "May classify a Driver" {
            tags "Optional Relationship"
        }

        standingEntry -> team "May classify a Team" {
            tags "Optional Relationship"
        }


        driver -> teamMembership "Has explicit historical memberships"

        teamMembership -> team "References"

        teamMembership -> resultEntry "Does not define or rewrite historical race representation" {
            tags "Independence"
        }
    }


    views {

        custom "CoreHistoricalDomain" {
            title "SimPaddock - Core Historical Relationship Map"
            description "Conceptual model of competitions, races, results, drivers, teams and source-backed historical representation."

            include *

            autoLayout tb
        }


        styles {

            element "Element" {
                shape RoundedBox
                background #dddddd
                color #222222
                stroke #888888
                description true
            }

            element "Domain Entity" {
                background #438dd5
                color #ffffff
                stroke #2e6295
            }

            element "Aggregate Root" {
                stroke #08427b
                strokeWidth 3
            }

            element "Historical Record" {
                background #1168bd
                color #ffffff
                stroke #0b4884
            }

            element "Critical Record" {
                background #08427b
                color #ffffff
                stroke #052f59
                strokeWidth 3
            }

            element "Historical Relationship" {
                background #5b7fa3
                color #ffffff
            }

            element "Catalog Entity" {
                background #888888
                color #ffffff
                stroke #666666
            }

            element "Optional Structure" {
                border dashed
            }


            relationship "Relationship" {
                color #707070
                thickness 2
                routing Curved
            }

            relationship "Optional Relationship" {
                color #888888
                style dashed
            }

            relationship "Evidence Relationship" {
                color #1168bd
                thickness 3
            }

            relationship "Independence" {
                color #999999
                style dotted
            }
        }
    }
}
