workspace "SimPaddock" "Sim Motorsport history platform" {

    model {
        publicVisitor = person "Public Visitor" {
            description "Searches and browses public driver, team, organisation, competition, result, achievement and historical information."
        }

        driver = person "Driver" {
            description "Claims and manages a source-backed Driver Profile after successful identity verification."
        }

        teamManager = person "Team Manager" {
            description "Manages team identity, roster, membership, roles and team structure."
        }

        competitionStaff = person "Competition Staff" {
            description "Manages organisations, competitions and authoritative competition records according to assigned roles and permissions."
        }

        simpaddock = softwareSystem "SimPaddock" {
            description "Drivers, Teams & Competition — Sim Motorsport History Platform."
        }

        discord = softwareSystem "Discord" {
            description "Provides authentication and external identity evidence."
            tags "Identity Provider"
        }

        steam = softwareSystem "Steam" {
            description "Provides authentication and external identity evidence."
            tags "Identity Provider"
        }

        simgrid = softwareSystem "SimGrid" {
            description "Trusted external source of sim-racing identities, teams, competitions, entries and results."
            tags "Trusted Racing Data Source"
        }

        gridFinder = softwareSystem "Grid Finder" {
            description "Trusted external source of sim-racing teams, leagues, competitions and results where integration access permits."
            tags "Trusted Racing Data Source"
        }

        raceControl = softwareSystem "RaceControl" {
            description "Trusted external source of LMU identities, events, ratings and race results."
            tags "Trusted Racing Data Source"
        }

        publicVisitor -> simpaddock "Searches and browses public motorsport history"

        driver -> simpaddock "Claims and manages Driver Profile"
        teamManager -> simpaddock "Manages team identity, roster, membership and roles"
        competitionStaff -> simpaddock "Manages organisations, competitions and authoritative records"

        discord -> simpaddock "Provides authentication and identity evidence"
        steam -> simpaddock "Provides authentication and identity evidence"

        simgrid -> simpaddock "Provides trusted racing data"
        gridFinder -> simpaddock "Provides trusted racing data"
        raceControl -> simpaddock "Provides trusted LMU identity and racing data"
    }

    views {
        systemContext simpaddock "SystemContext" {
            include *
            autoLayout tb

            title "SimPaddock — System Context"
            description "Public-first sim motorsport history platform and its users, identity providers and trusted racing data sources."
        }

        styles {
            element "Person" {
                shape Person
            }

            element "Software System" {
                background #1168bd
                color #ffffff
            }

            element "Identity Provider" {
                background #666666
                color #ffffff
            }

            element "Trusted Racing Data Source" {
                background #438dd5
                color #ffffff
            }
        }
    }
}
