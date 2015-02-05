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

post1= OriginalPost.create({
    user_id: 1,
    content: "This is a post about cars",
    title: "cars",
    post_type: "video"
  })
post2 = OriginalPost.create({
    user_id: 2,
    content: "This is a post about boats",
    title: "Boats",
    post_type: "image"
  })
post3 = OriginalPost.create({
    user_id: 1,
    content: "I am having such a wonderful day",
    title: "My day",
    post_type: "text"
  })
post4 = OriginalPost.create({
    user_id: 2,
    content: "This is a post about football",
    title: "football",
    post_type: "video"
  })


MediaUrl.create([
  {
    post_id: post1.id,
    url: "https://www.youtube.com/watch?v=bBH0ele7qdw"
  },
  {
    post_id: post2.id,
    url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ807Vag4b7cBo9xl4zlKiNb-s-aFG8cocPyGQJRqNVbsIH5EZ1KQOz0w4N"
  },
  {
    post_id: post4.id,
    url: "https://www.youtube.com/watch?v=-lGrARvsuD0"
  }

  ])
UserBlogPost.create({post_id: post1.id, post_type: "OriginalPost", user_id: post1.user_id })
UserBlogPost.create({post_id: post2.id, post_type: "OriginalPost", user_id: post2.user_id })
UserBlogPost.create({post_id: post3.id, post_type: "OriginalPost", user_id: post3.user_id })
UserBlogPost.create({post_id: post4.id, post_type: "OriginalPost", user_id: post4.user_id })

reblog1 = Reblog.create({user_id: 1, post_id: post2.id})
reblog2 = Reblog.create({user_id: 2, post_id: post3.id})
reblog3 = Reblog.create({user_id: 6, post_id: post4.id})
UserBlogPost.create({post_id: reblog1.id, post_type: "Reblog", user_id: reblog1.user_id })
UserBlogPost.create({post_id: reblog2.id, post_type: "Reblog", user_id: reblog2.user_id })
UserBlogPost.create({post_id: reblog3.id, post_type: "Reblog", user_id: reblog3.user_id })
















