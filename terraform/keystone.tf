# maint seq=250
# Keystone — primary PostgreSQL (system of record).
# ADR-014 / PLT-204: SHARD phase-1 — partition Keystone by portfolio for scale.
# Adds a second shard primary; portfolios are routed to a shard by hash.

resource "aws_db_instance" "keystone_primary" {
  identifier        = "keystone-shard-0"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.r6g.2xlarge"
  allocated_storage = 500
  multi_az          = true
}

resource "aws_db_instance" "keystone_shard_1" {
  identifier        = "keystone-shard-1"
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
