# Keystone — primary PostgreSQL (system of record).
# ADR-021 (Accepted 2026-05-12) REVERTS the ADR-014 sharding decision. After the
# read-replica-lag SEV-2, we go back to a SINGLE primary and add pgbouncer connection
# pooling instead of partitioning by portfolio. ADR-014 is now Superseded.

resource "aws_db_instance" "keystone_primary" {
  identifier        = "keystone-primary"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.r6g.4xlarge"  # scaled up in lieu of sharding
  allocated_storage = 1000
  multi_az          = true
}

# keystone_shard_1 removed: sharding reverted per ADR-021.

resource "aws_db_instance" "keystone_replica" {
  count               = 2
  identifier          = "keystone-replica-${count.index}"
  replicate_source_db = aws_db_instance.keystone_primary.identifier
  instance_class      = "db.r6g.xlarge"
}

# pgbouncer connection pooling — the scale answer instead of sharding (ADR-021).
resource "aws_ecs_service" "pgbouncer" {
  name            = "keystone-pgbouncer"
  desired_count   = 2
}
