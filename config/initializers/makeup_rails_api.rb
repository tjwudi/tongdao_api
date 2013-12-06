# -*- encoding : utf-8 -*-
# Issue : http://stackoverflow.com/questions/13745689/getting-rails-api-and-strong-parameters-to-work-together
ActionController::API.send :include, ActionController::StrongParameters

# Issue : Want to use http authentication
ActionController::API.send :include, ActionController::HttpAuthentication::Token::ControllerMethods

