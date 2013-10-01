# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
     Movie.create!(movie)
  end
 # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2), "Incorrect Order"
 # flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  rating_list.split(",").each do |rating|
    rating = "ratings_"+ rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end 
end

When /I (un)?check all of the ratings$/ do |uncheck|
  Movie.all_ratings.each do |rating|
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end

Then /I should (not )?see movies rated: (.*)/ do |negated, rating_list|

  ratings = rating_list.split(",")
  if negated
    ratings = Movie.all_ratings - ratings
  end
  size = filtered_movies = Movie.find_all_by_rating(ratings).size
    page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{size} ]")
end

Then /I should see (none|all) of the movies/ do |filter|
  size = 0
  size = Movie.all.size if filter =="all"
end
  

