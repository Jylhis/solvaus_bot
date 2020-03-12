# frozen_string_literal: true

require 'telegram/bot'

token = 'ADD-TELEGRAM-BOT-TOKEN-HERE'

start = [
  'Senkin',
  'Vietävän',
  'Sinä',
  'Sinä senkin',
  'Tuhannen',
  'Mikäkin',
  'Riivatun',
  'Joutavanpäiväinen',
  'Mokoma',
  'Mokomakin',
  'Vihelinäinen',
  'Turskatin',
  'Halvatun'
]
start_count = start.count

names = []
long_insults = []

File.open('./nimet.txt', 'r') do |f|
  f.each_line do |line|
    if line.split(' ').count > 1
      long_insults.push(line)
    else
      names.push(line.strip)
    end
  end
end

names_count = names.count
long_insults_count = long_insults.count

puts 'Starting server'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/solvaus'
      rnd_value = Random.rand(start_count)
      puts rnd_value
      start_value = start[rnd_value]

      puts start_value
      insult = if Random.rand(100).even?
                 names[Random.rand(names_count)] + ' ' + names[Random.rand(names_count)]
               else
                 (long_insults[Random.rand(long_insults_count)]).to_s
               end
      puts insult
      bot.api.send_message(chat_id: message.chat.id, text: "#{start_value} #{insult}")
    end
  end
end
