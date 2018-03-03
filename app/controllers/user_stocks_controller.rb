class UserStocksController < ApplicationController

  def create
    stock = Stock.find_by_ticker(params[:stock_ticker])
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:success] = "Stock #{@user_stock.stock.name} was successfully added to portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    @user_stock.destroy
    flash[:notice] = "Stock was successfully removed from portfolio"
    redirect_to my_portfolio_path
  end

  def daily_change
    stock = Stock.find(params[:id])
    today_stock = StockQuote::Stock.history("#{stock.symbol}", Date.today, Date.today)
    if today_stock[:history].empty?
      today_stock = StockQuote::Stock.history("#{stock.symbol}", 1.day.ago, 1.day.ago)
      yesterday_stock = StockQuote::Stock.history("#{stock.symbol}", 2.days.ago, 2.days.ago)
    else
      yesterday_stock = StockQuote::Stock.history("#{stock.symbol}", 1.day.ago, 1.day.ago)
    end
    today_stock_close = today_stock[:history][0][:close]
    yesterday_stock_close = yesterday_stock[:history][0][:close]
    @daily_change = (today_stock_close - yesterday_stock_close).round(2)
  end

  helper_method :daily_change
end
