require 'mail'

def send_email(sender_email, sender_password, recipient_email, subject, body, headers_editable)
  options = {
    address: 'smtp.yourprovider.com',
    port: 587,
    user_name: sender_email,
    password: sender_password,
    authentication: :plain,
    enable_starttls_auto: true
  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  mail = Mail.new do
    from sender_email
    to recipient_email
    subject subject
    body body
  end

  # Customize headers based on editability settings
  headers_editable.each do |header, editable|
    if editable == true
      mail.header[header] = "Editable || will not trigger filters"
    else
      mail.header[header] = nil  # Remove the header
    end
  end

  # Send the email
  mail.deliver!
  puts 'Email sent successfully'
end

# Example usage
sender_email = 'your_email@example.com'
sender_password = 'your_email_password'
recipient_email = 'recipient@example.com'
subject = 'Test Email'
body = 'This is a test email.'

headers_editable = {
  'Received' => true,
  'Authentication-Results' => true,
  'Received-SPF' => true,
  'DKIM-Signature' => true,
  'To' => true,
  'Message-ID' => false,
  'Date' => true,
  'Content-Type' => true,
  'MIME-Version' => true,
  'Reply-To' => true,
  'X-Campaign-ID' => true,
  'From' => true,
  'Subject' => true,
  'X-Message-ID' => true,
  'X-Feedback-ID' => true,
  'Feedback-ID' => true,
  'Return-Path' => true,
  'X-MS-Exchange-Organization-ExpirationStartTime' => true,
  'X-MS-Exchange-Organization-ExpirationStartTimeReason' => true,
  'X-MS-Exchange-Organization-ExpirationInterval' => true,
  'X-MS-Exchange-Organization-ExpirationIntervalReason' => true,
  'X-MS-Exchange-Organization-Network-Message-Id' => true,
  'X-EOPAttributedMessage' => true,
  'X-EOPTenantAttributedMessage' => true,
  'X-MS-Exchange-Organization-MessageDirectionality' => true,
  'X-MS-PublicTrafficType' => true,
  'X-MS-TrafficTypeDiagnostic' => true,
  'X-MS-Exchange-Organization-AuthSource' => true,
  'X-MS-Exchange-Organization-AuthAs' => true,
  'X-MS-Office365-Filtering-Correlation-Id' => true,
  'X-MS-Exchange-Organization-SCL' => true,
  'X-Microsoft-Antispam' => true,
  'X-Forefront-Antispam-Report' => true,
  'X-MS-Exchange-CrossTenant-OriginalArrivalTime' => true,
  'X-MS-Exchange-CrossTenant-Network-Message-Id' => true,
  'X-MS-Exchange-CrossTenant-Id' => true,
  'X-MS-Exchange-CrossTenant-AuthSource' => true,
  'X-MS-Exchange-CrossTenant-AuthAs' => true,
  'X-MS-Exchange-CrossTenant-FromEntityHeader' => true,
  'X-MS-Exchange-Transport-CrossTenantHeadersStamped' => true,
  'X-MS-Exchange-Transport-EndToEndLatency' => true,
  'X-MS-Exchange-Processed-By-BccFoldering' => true,
  'X-Microsoft-Antispam-Mailbox-Delivery' => true,
  'X-Microsoft-Antispam-Message-Info' => true
}

send_email(sender_email, sender_password, recipient_email, subject, body, headers_editable)
