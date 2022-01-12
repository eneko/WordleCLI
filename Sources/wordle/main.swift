import Foundation
import Rainbow

/// We all need some constants in life
struct Constants {
    static let letters = 5
    static let attempts = 6
    static let separator = " "
}

/// Game board, with solution and attempts
struct Board {
    let solution: String
    var attempts: [String] = []

    var isSolved: Bool {
        attempts.contains(solution)
    }

    func render() -> String {
        var rows = [String]()
        for rowIndex in 0..<Constants.attempts {
            let attempt = attempts.count > rowIndex ? attempts[rowIndex] : nil
            rows.append(renderRow(attempt: attempt))
        }
        return rows.joined(separator: "\n")
    }

    private func renderRow(attempt: String?) -> String {
        guard let attempt = attempt?.lowercased() else {
            return Array(repeating: "▯", count: Constants.letters).joined(separator: Constants.separator)
        }
        var letters: [String] = []
        for (solutionLetter, attemptLetter) in zip(solution, attempt) {
            if solutionLetter == attemptLetter {
                letters.append(String(attemptLetter).capitalized.green)
            }
            else if solution.contains(attemptLetter) {
                letters.append(String(attemptLetter).capitalized.yellow)
            }
            else {
                letters.append(String(attemptLetter).capitalized.lightBlack)
            }
        }
        return letters.joined(separator: Constants.separator)
    }
}

struct Wordle {
    static func main() {
        print("Welcome to Wordle, here is a random puzzle:")

        guard let word = words.randomElement() else {
            fatalError("Could not find a word to play")
        }

        var board = Board(solution: word)

        while true {
            print(board.render())

            // If the board is solved, we are done
            if board.isSolved {
                print("Congratulations, you solved the puzzle!".green)
                exit(0)
            }

            // Users have a fixed amount of tries
            if board.attempts.count == Constants.attempts {
                print("Sorry, you ran out of attempts. The solution was '\(board.solution.capitalized)'. Please try again!".red)
                exit(-1)
            }

            // Get new input from user
            print("Please enter a 5 letter word:")
            guard let input = readLine(strippingNewline: true) else {
                continue
            }
            if input.count < Constants.letters {
                print("Invalid word (too short)".yellow)
                continue
            }
            if input.count > Constants.letters {
                print("Invalid word (too long)".yellow)
                continue
            }
            guard words.contains(input) else {
                print("Word not found in dictionary, please enter a different word".yellow)
                continue
            }
            board.attempts.append(input)
        }
    }
}

Wordle.main()
