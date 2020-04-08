module.exports = [
  [/\/admin\/v1\/auth_user(?:\/(\d+))?/, 'admin/v1/auth_user?id=:1', 'rest'],
  [/\/admin\/v1\/auth_role(?:\/(\d+))?/, 'admin/v1/auth_role?id=:1', 'rest'],
];


