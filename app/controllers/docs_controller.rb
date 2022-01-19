require "csv"

class DocsController < ApplicationController

  def create

    upload = params[:doc][:attachment]
    path = Rails.root.join('public', 'uploads', upload.original_filename)

    File.open(path, 'wb') do |file|
      file.write(upload.read)
    end

    parsed = CSV.read(path, col_sep: "\t")

    #Remove header
    parsed.shift()

    for data in parsed

      purchaser_name =  data[0]
      item_description =  data[1]
      item_price =  data[2]
      purchase_count =  data[3]
      merchant_address =  data[4]
      merchant_name =  data[5]

      unless Purchaser.exists?(name:purchaser_name)
        @purchaser = Purchaser.new(name:purchaser_name)
        @purchaser.save
      end

      @merchant = Merchant.where(name:merchant_name).first

      unless @merchant
        @merchant = Merchant.new(
          name:merchant_name,
          address:merchant_address,
          )
        @merchant.save
      end

      unless Item.exists?(description:item_description)
        @item = Item.new(
          description:item_description,
          price:item_price,
          merchant_id: @merchant.id
          )
        @item.save
      end

      # # Puserchase.new(purchase_count)
    end



    # if Purchaser.exists?(name:name)
    #   Purchaser.new(name:name)

    # end
    # if Purchaser.exists?(name:name)
    # @purchaser = Purchaser.new(name:name)
    # @purchaser.save

    # `purchaser name`, `item description`, `item price`, `purchase count`, `merchant address`, `merchant name`

    # @doc = Doc.new(docs_params)
    # if @doc.save
    #   redirect_to "/", notice: "Successfully uploaded."
    # else
    #   render "new"
    # end

  end

  private
    def docs_params
    params.require(:doc).permit(:attachment)
  end

end
