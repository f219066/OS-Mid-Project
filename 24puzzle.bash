#!/usr/bin/env bash

OS LAB MID PROJECT
21F-9060 - Muhammad Haaris
21F-9066- Muhammad Bilal Qureshi


24 PUZZLE GAME 

CODE ORGANISATION
The code is organised into several functions, each handling a particular set of duties. The main responsibilities and their duties are broken down as follows:
init():  Creates a 5x5 grid with integers ranging from 1 to 25 at random to start the puzzle in its initial state. The symbol for the empty space is "25." It publishes the starting condition as well.
goal():  creates a random goal state on a 5x5 grid with integers ranging from 1 to 25. In the objective state, the vacant space is denoted by "25." The objective state is also printed.
is_solveable():  Verifies if the puzzle can be solved by comparing the initial and goal states' inversions. The puzzle is regarded as solved if there are an equal number of inversions in both states.
is_goal() :  Compares the numbers in the two states to see if the puzzle's present state and its intended state match. When all the numbers line up, the puzzle is deemed solved.
makemoves():  This function enables the player to move left, right, up, or down in order to complete the problem. Until the riddle is solved, the player has two options: either keep moving or decide to give up. Additionally, it keeps note of how many movements are done in all directions (up, down, left, and right).
printpath():  Outputs the puzzle's current condition, complete with the number arrangement and empty space.

Game Play
Take these actions to play the game and figure out the puzzle:
Launch the application to set up the problem and determine whether it can be solved.
To move the empty area, type 'U' for up, 'D' for down, 'L' for left, or 'R' for right. Finding a match between the numbers in the beginning state and the goal state is the aim.
Proceed with your movements and observe the puzzle's current status by using the printpath() function.
Follow these set of rules:
The empty space may only be moved to nearby locations.
Moving empty space outside of the grid is an example of an illegal move.
The software is going to let you know if you make a mistake.
Until the puzzle is solved and the starting state corresponds to the desired state, keep moving and changing the numbers.
When the riddle is solved, the programme will show the solution.
Anytime you want to stop playing the game, just type 'E.'

Code:

#!/bin/bash

declare -a a
declare -a b

init() {
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            a[$((i * 5 + j))]=$((1 + RANDOM % 25))
        done
    done

    echo "Initial state"
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            idx=$((i * 5 + j))
            if [[ ${a[$idx]} -eq 25 ]]; then
                printf "%4s" "  "
                c=${a[$idx]}
                row=$i
                column=$j
            else
                printf "%4d" ${a[$idx]}
            fi
        done
        echo
    done
}

goal() {
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            b[$((i * 5 + j))]=$((1 + RANDOM % 25))
        done
    done
    echo
    echo "Goal state"
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            idx=$((i * 5 + j))
            if [[ ${b[$idx]} -eq 25 ]]; then
                printf "%4s" "  "
            else
                printf "%4d" ${b[$idx]}
            fi
        done
        echo
    done
}

is_solveable() {
    count=0
    count1=0
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            for ((x=0; x<5; x++)); do
                for ((y=j; y<5; y++)); do
                    if [[ ${a[$((i * 5 + j))]} -gt ${a[$((x * 5 + y))]} ]]; then
                        count=$((count + 1))
                    fi
                done
            done
        done
    done
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            for ((x=0; x<5; x++)); do
                for ((y=j; y<5; y++)); do
                    if [[ ${b[$((i * 5 + j))]} -gt ${b[$((x * 5 + y))]} ]]; then
                        count1=$((count1 + 1))
                    fi
                done
            done
        done
    done
    if [[ $((count % 2)) -eq 0 && $((count1 % 2)) -eq 0 ]]; then
        return 0
    elif [[ $((count % 2)) -ne 0 && $((count1 % 2)) -ne 0 ]]; then
        return 0
    else
        return 1
    fi
}

makemoves() {
    isGO=true
    upMove=0
    downMove=0
    leftMove=0
    rightMove=0
    while [[ $isGO == true ]]; do
        for ((i=0; i<5; i++)); do
            for ((j=0; j<5; j++)); do
                idx=$((i * 5 + j))
                if [[ ${a[$idx]} -eq 25 ]]; then
                    row=$i
                    column=$j
                fi
            done
        done

        echo "Enter your move or E to exit:"
        read -r move
        goal
        echo -e "\nInitial State: "
        echo -e "\n"

        case $move in
            [Uu])
                if ((row > 0)); then
                    # Implement the 'U' move
                    temp=${a[$((row * 5 + column))]}
                    a[$((row * 5 + column))]=${a[$(((row - 1) * 5 + column))]}
                    a[$(((row - 1) * 5 + column))]=$temp
                    row=$((row - 1))
                    upMove=$((upMove + 1))
                else
                    echo "Illegal move"
                fi
                ;;
            [Dd])
                if ((row < 4)); then
                    # Implement the 'D' move
                    temp=${a[$((row * 5 + column))]}
                    a[$((row * 5 + column))]=${a[$(((row + 1) * 5 + column))]}
                    a[$(((row + 1) * 5 + column))]=$temp
                    row=$((row + 1))
                    downMove=$((downMove + 1))
                else
                    echo "Illegal move"
                fi
                ;;
            [Rr])
                if ((column < 4)); then
                    # Implement the 'R' move
                    temp=${a[$((row * 5 + column))]}
                    a[$((row * 5 + column))]=${a[$((row * 5 + column + 1))]}
                    a[$((row * 5 + column + 1))]=$temp
                    column=$((column + 1))
                    rightMove=$((rightMove + 1))
                else
                    echo "Illegal move"
                fi
                ;;
            [Ll])
                if ((column > 0)); then
                    # Implement the 'L' move
                    temp=${a[$((row * 5 + column))]}
                    a[$((row * 5 + column))]=${a[$((row * 5 + column - 1))]}
                    a[$((row * 5 + column - 1))]=$temp
                    column=$((column - 1))
                    leftMove=$((leftMove + 1))
                else
                    echo "Illegal move"
                fi
                ;;
            [Ee])
                isGO=false
                ;;
            *)
                echo "Wrong move"
                ;;
        esac
        printpath
    done

    totalMove=$((leftMove + rightMove + upMove + downMove))
}

printpath() {
    for ((i=0; i<5; i++)); do
        for ((j=0; j<5; j++)); do
            idx=$((i * 5 + j))
            if [[ ${a[$idx]} -eq 25 ]]; then
                printf "%4s" " "
            else
                printf "%4d" ${a[$idx]}
            fi
        done
        echo
    done
}

init
goal
if is_solveable; then
    echo "Puzzle is solvable"
else
    echo "Puzzle is not solvable"
fi
makemoves

