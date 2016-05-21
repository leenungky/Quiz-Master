class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :question, :answer]

  
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end


  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create	
	question_param = question_params.merge(:words => in_words(question_params["answer"].to_i))
    @question = Question.new(question_param)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
	#=end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
	question_param = question_params.merge(:words => in_words(question_params["answer"].to_i))
	respond_to do |format|
      if @question.update(question_param)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end	
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def question		
  end
  
  
  def answer        
	answer = '';
	if (params[:question][:answer].present?)
		is_number = is_number?( params[:question][:answer])
		if (is_number)
			if (@question.answer == params[:question][:answer].to_i)
				answer = " correct" 
			else
				answer = " incorrect" 
			end
		else
			if (@question.words == params[:question][:answer])
				answer = " correct" 
			else
				answer = " incorrect" 
			end
		end
	else 
		answer = " incorrect" 
	end
	flash[:notice] = @question.question + ": " + params[:question][:answer].to_s + " "  + answer
	redirect_to question_questions_path(@question);		
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :answer)
    end
	
	def in_words(int)
	  numbers_to_name = {
		  1000000 => "million",
		  1000 => "thousand",
		  100 => "hundred",
		  90 => "ninety",
		  80 => "eighty",
		  70 => "seventy",
		  60 => "sixty",
		  50 => "fifty",
		  40 => "forty",
		  30 => "thirty",
		  20 => "twenty",
		  19=>"nineteen",
		  18=>"eighteen",
		  17=>"seventeen", 
		  16=>"sixteen",
		  15=>"fifteen",
		  14=>"fourteen",
		  13=>"thirteen",              
		  12=>"twelve",
		  11 => "eleven",
		  10 => "ten",
		  9 => "nine",
		  8 => "eight",
		  7 => "seven",
		  6 => "six",
		  5 => "five",
		  4 => "four",
		  3 => "three",
		  2 => "two",
		  1 => "one"
		}
	  str = ""
	  numbers_to_name.each do |num, name|
		if int == 0
		  return str
		elsif int.to_s.length == 1 && int/num > 0
		  return str + "#{name}"      
		elsif int < 100 && int/num > 0
		  return str + "#{name}" if int%num == 0
		  return str + "#{name} " + in_words(int%num)
		elsif int/num > 0
		  return str + in_words(int/num) + " #{name} " + in_words(int%num)
		end
	  end
	end
	
	def is_number? string
	  true if Float(string) rescue false
	end
end
