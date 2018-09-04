class ZenController < ApplicationController
  def show
    render plain: principles.sample
  end

  def principles
    [
      "Convention over configuration",
      "Design for failure",
      "Simple is better than complex",
      "Implementation details bring little value to users",
      "Make feedback actionable",
      "If it can't be reliable, you'd better not build it",
      "Swift code that reads like Bash is not Swift code",
    ]
  end
end
