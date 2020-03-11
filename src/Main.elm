module Main exposing (main)

import Playground exposing (..)


type State
    = RunTheRace Number
    | MoveToPodium ()


main =
    game view update (RunTheRace -300)


update : Computer -> State -> State
update _ memory =
    case memory of
        RunTheRace x ->
            if x > 290 then
                MoveToPodium ()

            else
                RunTheRace (x + 3)

        MoveToPodium () ->
            memory


view computer memory =
    case memory of
        RunTheRace x ->
            let
                time =
                    computer.time
            in
            [ myRings time x
                |> scale 0.2
                |> moveRight 10
                |> moveUp 100
                |> moveX (wave 10 -10 10 time)
            , medalStand |> scale 2 |> moveRight 150
            , myTrack |> scale 2 |> moveRight 150
            , myPeople time x |> scale 1 |> moveRight 2
            ]

        MoveToPodium () ->
            [ rectangle red 20 20 ]


myPeople time state =
    group
        [ myPerson |> moveDown 150 |> moveX state
        , myPerson |> moveDown 220 |> moveX state
        , myPerson |> moveDown 300 |> moveX state
        ]


myPerson =
    group
        [ rectangle black 10 45 |> moveUp 75 |> moveRight 8
        , rectangle black 10 20 |> moveUp 50 |> moveRight 16 |> rotate 45
        , rectangle black 10 20 |> moveUp 50 |> moveRight 0 |> rotate 140
        , rectangle black 10 20 |> moveUp 70 |> moveRight 0 |> rotate 140
        , rectangle black 10 20 |> moveUp 70 |> moveRight 16 |> rotate 45
        , circle black 12 |> moveUp 95 |> moveRight 7.5
        ]


medalStand =
    group
        [ rectangle orange 90 20
        , rectangle orange 30 40 |> moveUp 25
        , rectangle orange 30 30 |> moveUp 15 |> moveRight 30
        , rectangle orange 30 20 |> moveUp 10 |> moveLeft 30
        , words black "1"
        , words black "2" |> moveRight 30
        , words black "3" |> moveLeft 30
        ]


myTrack =
    group
        [ rectangle red 1200 100 |> moveDown 90
        , rectangle white 1000 5 |> moveDown 105
        , rectangle white 1000 5 |> moveDown 70
        , rectangle white 5 100 |> moveDown 90 |> moveRight 50
        ]


myRings time state =
    group
        [ myCircle blue (moveLeft 160) (moveUp 100)
        , myCircle black (moveUp 100) (moveUp 0)
        , myCircle red (moveUp 100) (moveRight 160)
        , myCircle yellow (moveLeft 85) (moveUp 25)
        , myCircle green (moveRight 85) (moveUp 25)
        , rectangle black 600 25 |> moveDown 85
        , rectangle black 600 25 |> moveUp 210
        , rectangle black 25 300 |> moveLeft 288 |> moveUp 55
        , rectangle black 25 300 |> moveRight 288 |> moveUp 55
        ]


myCircle myColor x y =
    group
        [ circle myColor 75
            |> y
            |> x
        , circle white 55
            |> y
            |> x
        ]
