pets = [
  {
    name: "Everly B",
    species: "Dog",
    age: 13,
    owner: "Kari"
  },
  {
    name: "Gecky",
    species: "Gecko",
    age: 13,
    owner: "Dan"
  },
  {
    name: "Samson",
    species: "Cat",
    age: 13,
    owner: "Dee"
  },
  {
    name: "Ruth",
    species: "Dog",
    age: 7,
    owner: "Crystal"
  },
  {
    name: "Stinker",
    species: "dog",
    age: 14,
    owner: "Chris"
  },
  {
    name: "Coco",
    species: "Dog",
    age: 11,
    owner: "Ada"
  },
  {
    name: "Rex",
    species: "Dog",
    age: 9,
    owner: "Christine"
  },
  {
    name: "Piper",
    species: "Dog",
    age: 1,
    owner: "Jared"
  }
]

pets.each do |pet|
  Pet.create(pet)
end