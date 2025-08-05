resource "aws_key_pair" "controller-key" {
  key_name   = "controller-key"
  public_key = "<Add-Public-Key>"
}

resource "aws_key_pair" "server-key" {
  key_name   = "server-key"
  public_key = "<Add-Public-Key>"

}
