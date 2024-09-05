resource "null_resource" "file" {
    provisioner "local-exce" {
        command = "echo 'Massega: ${upper("hello world")}' > challenge.txt"
    }
}



  
