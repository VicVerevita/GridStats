workspace "SimPaddock - Bounded Contexts" "Domain bounded context map for SimPaddock." {

    model {
        discord = element "Discord" "Identity Provider" {
            description "External provider used for authentication and identity evidence."
            tags "External,Identity Provider"
        }

        steam = element "Steam" "Identity Provider" {
            description "External provider used for authentication and identity evidence."
            tags "External,Identity Provider"
        }

        simgrid = element "SimGrid" "Trusted Racing Data Source" {
            description "Trusted external source of drivers, teams, competitions, entries and results."
            tags "External,Trusted Racing Data Source"
        }

        gridFinder = element "Grid Finder" "Trusted Racing Data Source" {
            description "Trusted external source of drivers, teams, competitions and results where integration access permits."
            tags "External,Trusted Racing Data Source"
        }

        raceControl = element "RaceControl" "Trusted Racing Data Source" {
            description "Trusted external source of LMU identities, events, ratings and race results."
            tags "External,Trusted Racing Data Source"
        }


        accountsClaims = element "Accounts & Claims" "Bounded Context" {
            description "Owns user accounts, authentication connections, claims and verification evidence. Determines who is authenticated and what source-backed entity they may manage."
            tags "Bounded Context,Supporting"

            properties {
                "Owns" "UserAccount, AuthConnection, Claim, VerificationEvidence"
                "Question" "Who may manage what?"
            }
        }

        integrationsProvenance = element "Integrations & Provenance" "Bounded Context" {
            description "Protects the canonical domain from external platform models. Imports trusted source data, retains provenance and resolves external identities and records to canonical SimPaddock entities."
            tags "Bounded Context,Core"

            properties {
                "Owns" "TrustedSource, ExternalRecord, ExternalReference, CanonicalMapping, ImportBatch, IdentityResolution"
                "Question" "What evidence establishes this fact?"
            }
        }

        driverRegistry = element "Driver Registry" "Bounded Context" {
            description "Owns canonical driver identity and the driver's public profile information."
            tags "Bounded Context,Core"

            properties {
                "Owns" "Driver, DriverAlias, Profile, SocialLink, ExternalProfileLink"
                "Question" "Who is this driver?"
            }
        }

        teamManagement = element "Team Management" "Bounded Context" {
            description "Owns teams, explicit team membership, team roles, invitations and team management. Historical team structure such as Main, Academy and Community teams is future scope."
            tags "Bounded Context,Core"

            properties {
                "Owns" "Team, TeamMembership, TeamRole, TeamInvitation"
                "Question" "What is this team and who belongs to it?"
            }
        }

        organisationsCompetitions = element "Organisations & Competitions" "Bounded Context" {
            description "Owns organisations, organisation staff and permissions, competitions and source-backed competition structure. It records competition structure rather than operating the full competition lifecycle."
            tags "Bounded Context,Core"

            properties {
                "Owns" "Organisation, OrganisationMembership, OrganisationRole, Permission, Competition, Round, Race"
                "Optional" "Session - only when meaningfully established by a trusted source"
                "Question" "What organisations, competitions and races exist?"
            }
        }

        resultsRecords = element "Results & Records" "Bounded Context" {
            description "Owns the canonical historical record of what happened in competitions, including source-backed participant/team representation, standings, corrections and revisions."
            tags "Bounded Context,Core,Critical"

            properties {
                "Owns" "RaceResult, ResultEntry, ChampionshipStanding, StandingEntry, ResultCorrection, ResultRevision"
                "Question" "What actually happened?"
            }
        }

        motorsportCatalog = element "Motorsport Catalog" "Bounded Context" {
            description "Owns supporting motorsport reference data used by competitions and historical records."
            tags "Bounded Context,Supporting"

            properties {
                "Owns" "Game, Car, CarClass, Circuit, CircuitLayout"
                "Question" "What motorsport object does this record refer to?"
            }
        }

        publicHistory = element "Public History Read Models" "Projection / Read Model" {
            description "Derived public views assembled from canonical domain data. This is not an independent source of historical truth."
            tags "Projection"

            properties {
                "Provides" "Driver careers, team history, achievements, trophy cabinets, statistics, public profiles"
            }
        }


        discord -> accountsClaims "Provides authentication and identity evidence"
        steam -> accountsClaims "Provides authentication and identity evidence"

        simgrid -> integrationsProvenance "Provides trusted racing data"
        gridFinder -> integrationsProvenance "Provides trusted racing data"
        raceControl -> integrationsProvenance "Provides trusted LMU identity and racing data"

        accountsClaims -> driverRegistry "Grants verified management authority over claimed Driver Profiles"
        accountsClaims -> teamManagement "Grants verified management authority over claimed Teams"
        accountsClaims -> organisationsCompetitions "Grants verified management authority over claimed Organisations"

        integrationsProvenance -> driverRegistry "Maps source identities to canonical Drivers"
        integrationsProvenance -> teamManagement "Maps source teams and explicit membership evidence"
        integrationsProvenance -> organisationsCompetitions "Maps source organisations and competition structure"
        integrationsProvenance -> resultsRecords "Supplies normalized source-backed historical evidence"
        integrationsProvenance -> motorsportCatalog "Maps external games, cars, classes and circuits"

        teamManagement -> driverRegistry "References canonical Drivers as team members"

        resultsRecords -> driverRegistry "References canonical Drivers that participated"
        resultsRecords -> teamManagement "References canonical Teams represented in historical results"
        resultsRecords -> organisationsCompetitions "Records results and standings for races and competitions"
        resultsRecords -> motorsportCatalog "References source-backed cars, classes and circuits"

        driverRegistry -> publicHistory "Provides canonical driver identity and profile data"
        teamManagement -> publicHistory "Provides team and membership data"
        organisationsCompetitions -> publicHistory "Provides organisation and competition structure"
        resultsRecords -> publicHistory "Provides authoritative historical records"
        motorsportCatalog -> publicHistory "Provides motorsport reference data"
    }


    views {
        custom "BoundedContexts" "SimPaddock - Bounded Context Map" {
            include *
            autoLayout tb 250 180

            description "Domain boundaries and dependencies within SimPaddock. Bounded contexts represent logical domain/module boundaries, not independently deployable services."
        }

        styles {
            element "Element" {
                shape RoundedBox
                background #dddddd
                color #222222
                stroke #888888
            }

            element "Bounded Context" {
                background #1168bd
                color #ffffff
                stroke #0b4884
            }

            element "Core" {
                background #1168bd
                color #ffffff
                stroke #0b4884
            }

            element "Critical" {
                background #08427b
                color #ffffff
                stroke #052b51
            }

            element "Supporting" {
                background #438dd5
                color #ffffff
                stroke #2f6599
            }

            element "Projection" {
                background #999999
                color #ffffff
                stroke #666666
            }

            element "External" {
                background #666666
                color #ffffff
                stroke #444444
            }

            element "Trusted Racing Data Source" {
                background #438dd5
                color #ffffff
            }

            element "Identity Provider" {
                background #666666
                color #ffffff
            }

            relationship "Relationship" {
                color #707070
                thickness 2
                routing Orthogonal
            }
        }
    }
}
