# resource "azurerm_public_ip" "pip" {

#   for_each            = var.public_ip
#   name                = each.value.name
#   resource_group_name = var.rg_name
#   location            = var.location
#   allocation_method   = each.value.allocation_method

# }

resource "azurerm_public_ip" "pip" {
  for_each = var.public_ip

  name                = each.value.name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = each.value.allocation_method

  # ---------- OPTIONAL ----------
  sku        = lookup(each.value, "sku", "Standard")
  sku_tier   = lookup(each.value, "sku_tier", "Regional")
  zones      = lookup(each.value, "zones", null)
  ip_version = lookup(each.value, "ip_version", "IPv4")

  idle_timeout_in_minutes = lookup(each.value, "idle_timeout_in_minutes", null)

  domain_name_label       = lookup(each.value, "domain_name_label", null)
  domain_name_label_scope = lookup(each.value, "domain_name_label_scope", null)
  reverse_fqdn            = lookup(each.value, "reverse_fqdn", null)

  public_ip_prefix_id = lookup(each.value, "public_ip_prefix_id", null)

  ddos_protection_mode    = lookup(each.value, "ddos_protection_mode", "VirtualNetworkInherited")
  ddos_protection_plan_id = lookup(each.value, "ddos_protection_plan_id", null)

  ip_tags = lookup(each.value, "ip_tags", null)
  tags    = lookup(each.value, "tags", null)
}


