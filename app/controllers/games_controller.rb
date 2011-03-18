class GamesController < ApplicationController
  # GET /games
  # GET /games.xml
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new(
     :the_number => rand(10)+1,
     :guesses => 3,
     :won =>"true"
     )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])
  
    @messsage = compare_numbers(params[:game][:your_guess], params[:game][:the_number])
    
     guesses_left = params[:game][:guesses].to_i
     params[:game][:guesses] = guesses_left -1
     
     if @message == 'you win' 
      then params[:game][:won] = true
      @game.won = true
      else
      params[:game][:won] = false
      @game.won = false
      end

    respond_to do |format|
      if @game.save
        format.html { redirect_to(@game, :notice => @message) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])
    
      @messsage = compare_numbers(params[:game][:your_guess], params[:game][:the_number])
      
          
       guesses_left = params[:game][:guesses].to_i
       params[:game][:guesses] = guesses_left -1
       
      if @message == 'you win' then
      params[:game][:won] = true
      else
      params[:game][:won] = false
      end
     
      if  params[:game][:guesses] == 0 then
      @message = 'GAME OVER'
      end


    respond_to do |format|
    if @game.update_attributes(params[:game])
     
        format.html { redirect_to(@game, :notice => @message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
  
  def compare_numbers(your_guess,the_number)
  	
	message = "hello"
	
	response = @game.compare(your_guess, the_number)
	case 
	when response == 'true' then message = "you win" 
	when response == 'higher' then message = "my number is higher"
	when response == 'lower' then message = "my number is lower"
	else message = 'wrong'
	end
	
	@message = message
	return @message
  end

 
  
end
