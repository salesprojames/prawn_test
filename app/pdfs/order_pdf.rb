class OrderPdf < Prawn::Document

	def initialize(order, view)
		super(top_margin: 70)
		@order = order
		@view = view
		order_number
		line_items
		total_price
	end

	def order_number
		text "Order \##{@order.number}", size: 40, style: :bold, :align => :center
	end

	def line_items
		move_down 5
		table line_item_rows, :position => :center do
			row(0).font_style = :bold
			columns(1..3).align = :right
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end

	def line_item_rows
		[["Product", "Qty", "Unit Price", "Full Price"]] +
		@order.line_items.map do |item|
			[item.product, item.qty, price(item.unit_price), price(item.full_price)]
		end
	end

	def price(num)
		@view.number_to_currency(num)
	end

	def total_price
		@total_sum = 0
		@order.line_items.each do |line_item|
		@total_sum += line_item.full_price
		move_down 5
		end
		text "Total Price: <color rgb='ff0000'>#{price(@total_sum)}</color>", size: 16, 
																			  style: :bold,
																			  :align => :center,
																			  :inline_format => true
	end
end