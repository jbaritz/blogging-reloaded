# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# User.create!([
#   {
#     username: "John",
#     password: "John1234",
#     password_confirmation: "John1234",
#     email: "John@john.com"

#   },
#   {
#     username: "Mike",
#     password: "Mike1234",
#     password_confirmation: "Mike1234",
#     email: "Mike@mike.com"
#   },
#   {
#     username: "Sarah",
#     password: "Sarah1234",
#     password_confirmation: "Sarah1234",
#     email: "Sarah@sarah.com"
#   }
#   ])

Post.create([
  {
    user_id: 1,
    content: "This is a post about cars",
    title: "cars",
    post_type: "video"
  },
  {
    user_id: 2,
    content: "This is a post about boats",
    title: "Boats",
    post_type: "image"
  },
  {
    user_id: 1,
    content: "I am having such a wonderful day",
    title: "My day",
    post_type: "text"

  },
  {
    user_id: 2,
    content: "This is a post about football",
    title: "football",
    post_type: "video"
  }


  ])

MediaUrl.create([
  {
    post_id: 1,
    url: "https://www.youtube.com/watch?v=bBH0ele7qdw"
  },
  {
    post_id: 2,
    url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ807Vag4b7cBo9xl4zlKiNb-s-aFG8cocPyGQJRqNVbsIH5EZ1KQOz0w4N"
  },
  {
    post_id: 4,
    url: "https://www.youtube.com/watch?v=-lGrARvsuD0"
  }

  ])













