class Doc < ApplicationRecord
    mount_uploader :attachments, AttachmentUploader
end
