class ActionController::API
  include NewRelic::Agent::Instrumentation::ControllerInstrumentation
  include NewRelic::Agent::Instrumentation::Rails3::ActionController
end
