require "csv"

class DocsController < ApplicationController

  def create

    upload = params[:doc][:attachment]
    path = Rails.root.join('public', 'uploads', upload.original_filename)

    File.open(path, 'wb') do |file|
      file.write(upload.read)
    end

    parsed = CSV.read(path, col_sep: "\t")

    # meed loop
    name = parsed[1][0].to_s
    puts "ok"
    puts Purchaser.exists?(name:name)
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
