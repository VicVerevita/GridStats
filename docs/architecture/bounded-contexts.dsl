workspace "SimPaddock - Bounded Contexts" "Domain bounded context map for SimPaddock." {

    model {

        discord = element "Discord" {
            description "External identity provider used for authentication and identity evidence."
            tags "External System,Identity Provider"
        }

        steam = element "Steam" {
            description "External identity provider used for authentication and identity evidence."
            tags "External System,Identity Provider"
        }

        simgrid = element "SimGrid" {
            description "Trusted external source of sim-racing identities, teams, competitions, entries and results."
            tags "External System,Trusted Racing Data Source"
        }

        gridFinder = element "Grid Finder" {
            description "Trusted external source of sim-racing teams, competitions and results where integration access permits."
            tags "External System,Trusted Racing Data Source"
        }

        raceControl = element "RaceControl" {
            description "Trusted external source of LMU identities, events, ratings and race results."
            tags "External System,Trusted Racing Data Source"
        }


        accountsClaims = element "Accounts & Claims" {
            description "Owns user accounts, authentication connections, claims and verification evidence. Answers who may manage a source-backed entity."
            tags "Bounded Context,Supporting Context"
        }

        driverRegistry = element "Driver Registry" {
            description "Owns canonical driver identities and public driver profile information."
            tags "Bounded Context,Core Context"
        }

        teamManagement = element "Team Management" {
            description "Owns canonical teams, explicit team memberships, team roles, invitations and team management."
            tags "Bounded Context,Core Context"
        }

        organisationsCompetitions = element "Organisations & Competitions" {
            description "Owns organisations, organisation memberships and permissions, competitions, optional rounds and races."
            tags "Bounded Context,Core Context"
        }

        resultsRecords = element "Results & Records" {
            description "Owns source-backed race results, standings, historical driver/team representation, corrections and revisions."
            tags "Bounded Context,Core Context,Critical Core"
        }

        integrationsProvenance = element "Integrations & Provenance" {
            description "Owns trusted-source ingestion, external references, canonical mappings, identity resolution and provenance."
            tags "Bounded Context,Core Context,Critical Core"
        }

        motorsportCatalog = element "Motorsport Catalog" {
            description "Owns supporting reference data such as games, cars, car classes, circuits and layouts."
            tags "Bounded Context,Supporting Context"
        }

        publicHistory = element "Public History Read Models" {
            description "Derived projections used for public careers, achievements, trophy cabinets, statistics and historical views."
            tags "Read Model"
        }


        discord -> accountsClaims "Provides authentication and identity evidence"
        steam -> accountsClaims "Provides authentication and identity evidence"

        simgrid -> integrationsProvenance "Provides trusted racing data" {
            tags "Evidence Flow"
        }

        gridFinder -> integrationsProvenance "Provides trusted racing data" {
            tags "Evidence Flow"
        }

        raceControl -> integrationsProvenance "Provides trusted LMU identity and racing data" {
            tags "Evidence Flow"
        }


        accountsClaims -> driverRegistry "Grants management authority over successfully claimed Driver Profiles"

        accountsClaims -> teamManagement "Grants management authority over claimed Teams"

        accountsClaims -> organisationsCompetitions "Grants management authority over claimed Organisations"


        integrationsProvenance -> driverRegistry "Resolves external identities to canonical Drivers" {
            tags "Evidence Flow"
        }

        integrationsProvenance -> teamManagement "Resolves external teams to canonical Teams" {
            tags "Evidence Flow"
        }

        integrationsProvenance -> organisationsCompetitions "Imports source-backed organisations, competitions, rounds and races" {
            tags "Evidence Flow"
        }

        integrationsProvenance -> resultsRecords "Imports source-backed results and standings" {
            tags "Evidence Flow"
        }

        integrationsProvenance -> motorsportCatalog "Resolves source-specific games, cars, classes and circuits" {
            tags "Evidence Flow"
        }


        teamManagement -> driverRegistry "Team memberships reference canonical Drivers"

        resultsRecords -> driverRegistry "Results reference canonical Drivers"

        resultsRecords -> teamManagement "Results reference canonical Teams"

        resultsRecords -> organisationsCompetitions "Records results for source-backed competitions and races"

        organisationsCompetitions -> motorsportCatalog "References games and circuits when established by the source"

        resultsRecords -> motorsportCatalog "References cars and classes when established by the source"


        driverRegistry -> publicHistory "Feeds public driver projections" {
            tags "Projection"
        }

        teamManagement -> publicHistory "Feeds team and membership projections" {
            tags "Projection"
        }

        organisationsCompetitions -> publicHistory "Feeds competition history projections" {
            tags "Projection"
        }

        resultsRecords -> publicHistory "Feeds achievements, trophies and statistics" {
            tags "Projection"
        }
    }


    views {

        custom "BoundedContexts" {
            title "SimPaddock - Bounded Context Map"
            description "Domain boundaries and dependencies inside SimPaddock, together with identity providers and trusted racing data sources."

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

            element "Bounded Context" {
                background #438dd5
                color #ffffff
                stroke #2e6295
            }

            element "Core Context" {
                background #1168bd
                color #ffffff
                stroke #0b4884
            }

            element "Critical Core" {
                background #08427b
                color #ffffff
                stroke #052f59
                strokeWidth 3
            }

            element "Supporting Context" {
                background #438dd5
                color #ffffff
            }

            element "Read Model" {
                background #999999
                color #ffffff
                stroke #666666
                border dashed
            }

            element "External System" {
                background #666666
                color #ffffff
                stroke #444444
            }

            element "Identity Provider" {
                background #555555
                color #ffffff
            }

            element "Trusted Racing Data Source" {
                background #2f95c5
                color #ffffff
            }


            relationship "Relationship" {
                color #707070
                thickness 2
                routing Curved
            }

            relationship "Evidence Flow" {
                color #1168bd
                thickness 3
            }

            relationship "Projection" {
                color #777777
                style dashed
            }
        }
    }
}
