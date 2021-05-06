class Dislike < Preference
  belongs_to :comment, counter_cache: true
end
