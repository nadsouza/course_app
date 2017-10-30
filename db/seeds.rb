# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User data
userData = [
  ['John', 'Doe', 'john.doe@rmit.edu.au', 'Password123'],
  ['Jenny', 'Nguyen', 'jenny.nguyen@rmit.edu.au', 'Password123'],
  ['Jen', 'Doe', 'jen.doe@rmit.edu.au', 'Password123'],
  ['Luke', 'Dam', 'luke.dam@rmit.edu.au', 'Password123'],
  ['Ava', 'Brian', 'ava.brian@rmit.edu.au', 'Password123'],
  ['Johnny', 'Huynh', 'johnny.huynh@rmit.edu.au', 'Password123'],
]

# Create user data
userData.each do |firstname, lastname, email, password|
  User.create(firstname: firstname, lastname: lastname, email: email, password: password, password_confirmation: password)
end

# Crate courses
# Real course information is referenced from http://www1.rmit.edu.au/courses/
webProgramming = Course.new(name: 'Web Programming', user_id: 0, description: 'The course introduces you to the basic concepts of the World Wide Web, and the principles and tools that are used to develop Web applications. The course will provide an overview of Internet technology and will introduce you to current Web protocols, client side and server side programming, communication and design.')
progTechniques = Course.new(name: 'Programming Techniques', user_id: 3, description: 'This course introduces programming techniques, including Object-Oriented programming using the Java programming language. This course covers algorithm development using standard control structures, design methods such as step-wise refinement, the object oriented programming framework, the use of standard Java classes and interfaces, the use of container classes, disk file processing and introduces techniques for code reuse.')
progFundamentals = Course.new(name: 'Programming Fundamentals', user_id: 3, description: 'Programming skill represents a generic problem solving ability, and is considered essential for anyone involved in the development and maintenance of software systems.')
discrete = Course.new(name: 'Discrete Structures in Computing', user_id: 3, description: 'This course provides a foundation for Computer Science. Many other areas of Computer Science require the ability to work with concepts from discrete structures. Discrete structures include topics such as set theory, logic, graph theory, and probability theory. The material in discrete structures is pervasive in the areas of data structures and algorithms but appears elsewhere in Computer Science as well.')
compTheory = Course.new(name: 'Computing Theory', user_id: 2, description: 'Computing Theory introduces you to foundational issues in computer science. The emphasis is on understanding and applying foundational concepts and techniques. You will learn and apply fundamental theories of computing to computing problems. Topics include the study of formal models of computation and computability properties, measuring time requirements for a computation approaches to difficult problems, the use of grammars to specify syntax rules.')
industExp = Course.new(name: 'Approved Industry Experience', user_id: 2, description: 'This course is associated with industry experience in a full-time employment position, which is related or relevant to a future career in the field of your degree program. This course is intended to combine with INTE2377 Approved Industry Experience to form two semesters of continuous approved industry experience.')
softEngPrin = Course.new(name: 'Software Engineering Principles and Practice', user_id: 0, description: 'This course complements Approved Industry Experience and focuses on a number of key aspects of your work placement to gain familiarity with the trends and practices of software development in industry; to gain an appreciation of the professional aspects associated with software engineering; to reflect on the work placement and to place your experiences into the context of your personal growth.')

# Create categories
webDev = Category.create(name: 'Web Development')
computerScience = Category.create(name: 'Computer Science')
softEng = Category.create(name: 'Software Engineering')

# Assign courses to categories
webProgramming.categories << webDev
progTechniques.categories << webDev
progFundamentals.categories << webDev
webProgramming.categories << computerScience
progTechniques.categories << computerScience
progFundamentals.categories << computerScience
webProgramming.categories << softEng
progTechniques.categories << softEng
progFundamentals.categories << softEng
compTheory.categories << softEng
compTheory.categories << computerScience
discrete.categories << softEng
discrete.categories << computerScience
industExp.categories << softEng
softEngPrin.categories << softEng

# Prerequisites
prereqOne = Prerequisite.create(id: progFundamentals.id)
prereqThree = Prerequisite.create(id: discrete.id)

progTechniques.prerequisites << prereqOne
webProgramming.prerequisites << prereqOne
compTheory.prerequisites << prereqThree

# Create locations
locationOne = Location.create(name: '080.04.006')
locationTwo = Location.create(name: '056.05.097')
locationThree = Location.create(name: '057.03.010')
locationFour = Location.create(name: '080.04.011')

# Assign courses to locations
webProgramming.locations << locationOne
webProgramming.locations << locationTwo
progTechniques.locations << locationFour
progFundamentals.locations << locationOne
progFundamentals.locations << locationTwo
progFundamentals.locations << locationThree
progFundamentals.locations << locationFour
discrete.locations << locationThree
compTheory.locations << locationThree
industExp.locations << locationOne
industExp.locations << locationFour
softEngPrin.locations << locationTwo

webProgramming.save(validate: false)
progTechniques.save(validate: false)
progFundamentals.save(validate: false)
discrete.save(validate: false)
compTheory.save(validate: false)
industExp.save(validate: false)
softEngPrin.save(validate: false)
