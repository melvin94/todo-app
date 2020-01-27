class Task < ApplicationRecord
    validates :task, presence: true

    scope :done, -> { where(done: true) }
    scope :notdone, -> { where(done: false) }

end
