# maint seq=15
# Keystone — the primary PostgreSQL database (system of record).
# Founding topology: a single primary with read replicas. No sharding.

resource "aws_db_instance" "keystone_primary" {
  identifier        = "keystone-primary"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.r6g.2xlarge"
  allocated_storage = 500
  multi_az          = true
}

resource "aws_db_instance" "keystone_replica" {
  count               = 2
  identifier          = "keystone-replica-${count.index}"
  replicate_source_db = aws_db_instance.keystone_primary.identifier
  instance_class      = "db.r6g.xlarge"
}
