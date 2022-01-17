# delete all lists
puts "Deleting #{ActionController::Base.helpers.pluralize(List.all.length, "list")} from database before re-seeding"
List.destroy_all

names = [
  "Action",
  "Comedy",
  "Romance",
  "Documentary",
  "Just cool stuff I like ❤️"
]

names.each do |name|
  list = List.create(
    name: name
  )
  puts "Created new list '#{list.name}' in db"
end
