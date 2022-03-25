require 'ruby2d'
module View 
    class Ruby2DView
        
        def initialize
            @pixel_size = 50
        end

        def start(state)
            extend Ruby2D::DSL
            set(
                title:"Snake",
                height:@pixel_size * state.grid.row,
                width:@pixel_size * state.grid.col
            )
            show
        end

        def render(state)
            render_snake(state)
            render_food(state)
        end

        private
        def render_food(state) 
            extend Ruby2D::DSL
            food = state.food
            @food = Square.new(
                x: food.col * @pixel_size,
                y: food.row * @pixel_size,
                size: @pixel_size,
                color: 'yellow'
            )
        end
        def render_snake(state)
            @snake_position.each(&:remove) if @snake_position
            extend Ruby2D::DSL
            snake = state.snake
            @snake_position = snake.position.map do |position|
            Square.new(
                x: position.col * @pixel_size,
                y: position.row * @pixel_size,
                size: @pixel_size,
                color: 'green'
            )
        end
    end
end
end