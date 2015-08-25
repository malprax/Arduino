pusher = YAML.load_file(File.join(Arduino::Application.root, 'config/pusher.yml'))

Pusher.app_id = pusher_app_id
Pusher.key = pusher_key
Pusher.secret = pusher_secret



begin
  Arduino::Application.config.board = Dino::Board.new(Dino::TxRx.new)
  button = Dino::Components::Button.new(pin: 2, board: Arduino::Application.config.board)

  button.down do
    puts 'down'
    Pusher['button'].trigger!('down', { :some => 'data' })
  end

  button.up do
    puts 'up'
    Pusher['button'].trigger!('up', { :some => 'data' })
  end

rescue Dino::BoardNotFound
  puts 'The board is not connected'
end