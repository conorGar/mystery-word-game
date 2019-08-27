class Word
    # Stores the provided word in an instance variable and
    # setups up any other instance variables.
    attr_reader :guessedWord
    def initialize(word)
        @word = word
        @guessedWord = word
        initial_hide_word()
    end


    def initial_hide_word()
        chars = @word.split('')

        chars = chars.map do |char|
            char = '_'
        end
        @guessedWord = chars.join(',')

        @guessedWord =@guessedWord.tr(',', '')
        
        # @guessedWord = @guessedWord.gsub(@word, '_')

        # puts guessedWord
    end
  
    # Guess a letter in the word.
    # Should return a boolean. true if the letter is in the word, false if not.
    def guess?(letter)
        if !self_is_letter?(letter)
            puts  "Not a letter!"
            return false
        end
        if @word.include? letter
            if(@word.count(letter) > 1)
                while(@word.include? letter)
                    index = @word.index(letter)
                    @word.slice!(index,1)
                    @word[index] = '_'

                    puts @word
                    @guessedWord.slice!(index,0)
                    @guessedWord[index] = letter

                end
            else
            index = @word.index(letter)

            @guessedWord.slice!(index,0)
            @guessedWord[index] = letter



            end


            output_word()
            return true
        end
        p "Word does not contain #{letter}"
        return false
    end
  
    # Whether all letters in the word have been guessed correctly.
    def guessed_all_correct?
        if !@guessedWord.include? '_'
            p "You guessed them all correctly! YOU WIN!"
            return true
        end

        return false
    end
  
    # Display the current state of the guessed word for the player.
    def output_word
        p @guessedWord
    end
  
    # Check whether a provided character is a letter
    def self_is_letter?(character)

        if character.length > 1
            return false
        elsif character.to_i != 0
            return false
        else
            return true
        end
    end
  end
  
  class MysteryWordGame
    # Initialize any state in the game, and start the game loop.
    def initialize
        @mysteryWord = ""
        ask_for_word()
        game_loop()
    end

  
    def ask_for_word
        p "What is the mystery word?"   
        @mysteryWord = Word.new(gets.chomp)
        p @mysteryWord
    end
  
    # Run the game loop, which continues until the player wins or loses.
    def game_loop

        while @mysteryWord.guessed_all_correct? == false do
            p "The word is #{@mysteryWord.guessedWord}"
            p "Please enter a letter"
            @mysteryWord.guess?(gets.chomp)
        end
    end


  end
  
  MysteryWordGame.new

