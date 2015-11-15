class Movie < ActiveRecord::Base
  
  def self.ratings 
    ['G','PG','PG-13','R']
  end
  
  def self.filtered
    return Movie.where(:rating => params[:ratings].keys).all
  end
  
end
