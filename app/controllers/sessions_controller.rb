class SessionsController < Devise::SessionsController
  skip_before_filter :trial_expired?
end
