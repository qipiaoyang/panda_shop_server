module.exports = [
  [/\/admin\/v1\/auth_user(?:\/(\d+))?/, 'admin/v1/auth_user?id=:1', 'rest'],
  [/\/admin\/v1\/auth_role(?:\/(\d+))?/, 'admin/v1/auth_role?id=:1', 'rest'],
  [/\/admin\/v1\/menu(?:\/(\d+))?/, 'admin/v1/menu?id=:1', 'rest'],
  [/\/admin\/v1\/resource(?:\/(\d+))?/, 'admin/v1/resource?id=:1', 'rest'],
  [/\/admin\/v1\/resource_category(?:\/(\d+))?/, 'admin/v1/resource_category?id=:1', 'rest'],
];


