class SomeWorker
  include SuckerPunch::Worker

  def perform
    p "something happened"
  end
end