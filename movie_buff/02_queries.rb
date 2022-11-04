def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score).where('yr BETWEEN ? AND ? AND score BETWEEN ? AND ?', 1980, 1989, 3, 5)
end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
  Movie.having('MAX(score) <= 8').group(:yr).pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Movie.select('actors.id, actors.name').joins(:actors).where('movies.title = ?', title).order(:ord)
end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.select('movies.id, movies.title, actors.name').joins(:director, :castings).where('castings.ord = 1 AND castings.actor_id = movies.director_id')

end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  Actor.select('actors.id, actors.name, COUNT(castings.movie_id) AS roles').joins(:castings).where('castings.ord != ?',1).group('actors.id').limit(2).order('COUNT(castings.movie_id) DESC')
end