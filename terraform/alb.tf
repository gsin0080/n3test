# alb.tf

# Create application load balancer
resource "aws_alb" "main" {
    name            = "n3-load-balancer"
    subnets         = aws_subnet.public.*.id
    security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "app" {
    name        = "n3-target-group"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.n3_test.id
    target_type = "ip"
}


# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
    load_balancer_arn = aws_alb.main.id
    port              = var.app_port
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.app.id
        type             = "forward"
    }
}