module Actions
    def self.move_snake(state)
        next_direction = state.curr_direction
        next_position = calc_next_position(state)
        #verify if next move is valid
        if position_is_valid(state, next_position)
            move_snake_to(state, next_position)
        else
            end_game(state)

        end
    end

    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.curr_direction = direction
        else
            puts "Invalid Direction"
        end
        state
    end
    
    private

    def self.calc_next_position(state)
        current_position = state.snake.position.first
        case state.curr_direction
            when Model::Direction::UP
                #decrease row
                return Model::Coord.new(
                    current_position.row - 1, 
                    current_position.col
                )
            when Model::Direction::RIGHT
                #increment col
                return Model::Coord.new(
                    current_position.row,
                    current_position.col + 1
                )

            when Model::Direction::DOWN
                #increment row
                return Model::Coord.new(
                    current_position.row + 1,
                    current_position.col
                )

            when Model::Direction::LEFT
                #decrease col
                return Model::Coord.new(
                    current_position.row,
                    current_position.col - 1
                ) 
        end
    end
    def self.position_is_valid(state, position)
        #verify if is in the grid
        is_invalid =((position.row >= state.grid.row || position.row < 0) || (position.col>= state.grid.col || position.col < 0))
        return false if is_invalid
        #verify if is nor over the snake
        return !(state.snake.position.include? position)
    end
    def self.move_snake_to(state, next_position)
        new_position = [next_position] + state.snake.position[0...-1]
        state.snake.position = new_position
        state
    end
    def self.end_game (state)
        state.game_finished = true
        state
    end
    def self.next_direction_is_valid?(state, direction)
        case state.curr_direction
        when Model::Direction::UP
            return true if direction != Model::Direction::DOWN
        when Model::Direction::DOWN
            return true if direction != Model::Direction::UP
        when Model::Direction::RIGHT
            return true if direction != Model::Direction::LEFT
        when Model::Direction::LEFT
            return true if direction != Model::Direction::RIGHT
        end
        return false
    end
end