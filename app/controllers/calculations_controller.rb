class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length()

    #why doesn't the method below work?
    #@input_array = @text.split()
    # @count_spaceless = 0
    # @input_array.each do |entry|
    #   @x = entry.length()
    #   @count_spaceless = @countspaceless + @x.to_i
    # end

    #approach below fails if there is only 1 word!
    @character_count_without_spaces = @text.gsub(/\s+/, "").length

    def words(value)
      value.split(/\s+/).length
    end
    @word_count = words(@text)
    # alternate approach to get word count?
    #@word_array = @text.split()
    #@word_count = @word_array.length
    @word_array = @text.split()
    @occurrences = @word_array.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @months = @years * 12.0
    @apr_months = @apr / 12.0
    @numerator = @principal * @apr_months * ((1.0 + @apr_months)**@months)
    @denominator = ((1.0+@apr_months)**@months) - 1.0

    @monthly_payment = @numerator / @denominator

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @half = @count/2
    @half_int = @half.to_i

    @median = @numbers[@half_int]

    @sum = @sorted_numbers.inject(:+)

    @mean = @sum / @sorted_numbers.size

    @sumofsq = @sorted_numbers.inject(0){|accum, i| accum +(i-@mean)**2 }
    @variance = @sumofsq /(@sorted_numbers.length - 1).to_f

    @standard_deviation = Math.sqrt(@variance)

    @most_present_number_count = 0
    @sorted_numbers.each do |snum|
      if @sorted_numbers.count(snum) > @most_present_number_count
        @most_present_number_count = @sorted_numbers.count(snum)
        @most_present_number = snum
      end
    end
    @mode = @most_present_number


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
