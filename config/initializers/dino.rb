# pusher = YAML.load_file(File.join(Arduino::Application.root, 'config/pusher.yml'))

Pusher.app_id = '122739'
Pusher.key = '429f0dfaaec2f4d689e8'
Pusher.secret = '808cd9f52d25422d41ec'



begin
  Arduino::Application.config.board = Dino::Board.new(Dino::TxRx.new)
  button = Dino::Components::Button.new(pin: 13, board: Arduino::Application.config.board)

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