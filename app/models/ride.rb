class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user


  def enough_tickets
    if self.user.tickets >= self.attraction.tickets
      true
    end
  end

  def tall_enough
    if self.user.height >= self.attraction.min_height
      true
    end
  end

  def height_and_tickets
    if enough_tickets && tall_enough
      true
    end
  end

  def took_ride
    self.user.update(happiness: self.user.happiness + self.attraction.happiness_rating, tickets: self.user.tickets - self.attraction.tickets, nausea: self.user.nausea + self.attraction.nausea_rating)
    "Thanks for riding the #{self.attraction.name}!"
  end

  def take_ride
    if height_and_tickets
      took_ride
    elsif !tall_enough && enough_tickets
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    elsif !enough_tickets && tall_enough
      "Sorry. You do not have enough tickets the #{self.attraction.name}."
    else
      "Sorry. You do not have enough tickets the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    end
  end
end
