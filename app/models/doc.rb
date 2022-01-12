class Doc < ApplicationRecord
    mount_uploader :attachments, AttachmentUploader # Tells rails to use this uploader for this model.
end
