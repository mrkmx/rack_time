class DateFormat
  attr_reader :rejected_params

  FORMATS = { year:   '%Y',
              month:  '%m',
              day:    '%d',
              hour:   '%H',
              minute: '%M',
              second: '%S'}.freeze

  def initialize(params)
    @params = params
    @accepted_params = []
    @rejected_params = []
  end

  def format
    Time.now.strftime(@accepted_params.join('-'))
  end

  def check_formats
    params = @params.split(',')
    params.each do |param|
      if FORMATS.key?(param.to_sym)
        @accepted_params << FORMATS[param.to_sym]
      else
        @rejected_params << param
      end
    end
  end

  def success?
    @rejected_params.empty?
  end
end
