class BasicJob < Asynchronic::Job
  def call
    params[:input] + 1
  end
end


class SequentialJob < Asynchronic::Job

  def call
    async Step1
    async Step2, dependency: Step1, 
                 input: result(Step1)
  end

  class Step1 < Asynchronic::Job
    def call
      params[:input] * 10
    end
  end

  class Step2 < Asynchronic::Job
    def call
      params[:input] / 100
    end
  end

end


class GraphJob < Asynchronic::Job
  
  def call
    async Sum, input: params[:input]

    async TenPercent, dependency: Sum, 
                      input: result(Sum)

    async TwentyPercent, dependency: Sum, 
                         input: result(Sum)

    async Total, dependencies: [TenPercent, TwentyPercent], 
                 '10%' => result(TenPercent),
                 '20%' => result(TwentyPercent)

    result Total
  end

  class Sum < Asynchronic::Job
    def call
      params[:input] + 100
    end
  end

  class TenPercent < Asynchronic::Job
    def call
      params[:input] * 0.1
    end
  end

  class TwentyPercent < Asynchronic::Job
    def call
      params[:input] * 0.2
    end
  end

  class Total < Asynchronic::Job
    def call
      {'10%' => params['10%'], '20%' => params['20%']}
    end
  end

end


class ParallelJob < Asynchronic::Job
  def call
    params[:times].times do |i|
      async Child, input: params[:input], index: i
    end
  end

  class Child < Asynchronic::Job
    def call
      params[:input] * params[:index]
    end
  end
end


class NestedJob < Asynchronic::Job
  def call
    async Level1
  end

  class Level1 < Asynchronic::Job
    def call
      async Level2, input: params[:input] += 1
    end

    class Level2 < Asynchronic::Job
      def call
        params[:input] ** 2
      end
    end
  end
end


class DependencyAliasJob < Asynchronic::Job
  def call
    async Write, alias: :word_1,
                 text: 'Take'
    
    async Write, alias: :word_2, 
                 dependency: :word_1,
                 text: 'it', 
                 prefix: result(:word_1)
    
    async Write, alias: :word_3, 
                 dependency: :word_2,
                 text: 'easy', 
                 prefix: result(:word_2)

    result :word_3
  end

  class Write < Asynchronic::Job
    def call
      [params[:prefix], params[:text]].join(' ')
    end
  end
end


class CustomQueueJob < Asynchronic::Job
  queue :queue_1
  def call
    async Reverse, queue: :queue_2, input: params[:input]
    result Reverse
  end

  class Reverse < Asynchronic::Job
    queue :queue_3
    def call
      params[:input].reverse
    end
  end
end


class ExceptionJob < Asynchronic::Job
  def call
    raise 'Error for test'
  end
end


class InnerExceptionJob < Asynchronic::Job
  def call
    async ExceptionJob
  end
end


class WorkerJob < Asynchronic::Job
  def call
  end
end